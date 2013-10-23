package main

import (
  "os"
  "fmt"
  "net/http"
  "log"
  //"strconv"
  "database/sql"
  "text/template"
  _ "github.com/lib/pq"
  "github.com/gorilla/mux"
)

var (
  tmpl *template.Template
  db *sql.DB
  connectString = "user=dev dbname=teaserlead_development password=dev sslmode=disable"
)

type Teaser struct {
  Id string
  Image string
  Text string
}

type TeaserBlock struct {
  Type string
  Size string
  Teasers []Teaser
}

func main() {
  router := genereateRoute()
  tmpl = loadTemplate()
  dbConnect()
  defer db.Close()
  http.Handle("/", router)
  http.ListenAndServe(":8888", nil)
}

func dbConnect() {
  if db == nil {
    var err error
    db, err = sql.Open("postgres", connectString)
    if err != nil { log.Fatal(err) }
  }
}

func genereateRoute() *mux.Router {
  r := mux.NewRouter()
  r.HandleFunc("/js/{uid}.js", jsGenerate)
  r.HandleFunc("/teasers/{uid}", teasersGenerate)
  r.HandleFunc("/tmpl/reload", reloadTmpl)
  r.Methods("GET")
  return r
}

func reloadTmpl(w http.ResponseWriter, r *http.Request) {
  tmpl = loadTemplate()
}

func jsGenerate(w http.ResponseWriter, r *http.Request) {
  log.Println(r.Method, r.URL, r.Proto)
  w.Header().Set("Cache-Control", "public,max-age=31536000")
  fmt.Fprintf(w, "asdasd")
}

func getType(r *http.Request) string {
  var teaser_type string
  values := r.URL.Query()
  if values["type"] != nil {
    teaser_type = values["type"][0]
  }else{
    teaser_type = "hor"
  }
  return teaser_type
}

func getSize(r *http.Request) string {
  var teaser_size string
  values := r.URL.Query()
  if values["size"] != nil {
    teaser_size = values["size"][0]
  }else{
    teaser_size = "50"
  }
  return teaser_size
}


func loadTemplate() *template.Template {
  dir, _ := os.Getwd()
  tmpl, err := template.New("teasers").ParseFiles(dir+"/deamon/teaser_block_hor.tpl")
  if err != nil { log.Println(err) }
  return tmpl
}

func (t *TeaserBlock) renderCss(w http.ResponseWriter, tmpl *template.Template){
  if err:= tmpl.ExecuteTemplate(w, "css", ""); err != nil { log.Println(err) }
}

func (t *TeaserBlock) renderBlock(w http.ResponseWriter, tmpl *template.Template) {
  if err:= tmpl.ExecuteTemplate(w, "teasers", t); err != nil { log.Println(err) }
}

func teasersGenerate(w http.ResponseWriter, r *http.Request) {
  //w.Header().Set("Status", "200")
  teaser_block := new(TeaserBlock)
  //vars := mux.Vars(r)
  teaser_block.Type = getType(r)
  teaser_block.Size = getSize(r)
  log.Println(r.Method, r.URL, r.Proto)
  teasers, err := db.Query("SELECT id, image, text FROM teasers ORDER BY RANDOM() LIMIT 3")
  if err != nil { log.Println(err) }
  for teasers.Next() {
    var teaser Teaser
    if err := teasers.Scan(&teaser.Id, &teaser.Image, &teaser.Text); err != nil { log.Println(err) }
    teaser_block.Teasers = append(teaser_block.Teasers, teaser)
  }
  if err := teasers.Err(); err != nil { log.Fatal(err) }

  teaser_block.renderCss(w, tmpl)
  teaser_block.renderBlock(w, tmpl)

}

{{define "teasers"}}
{{$size:= .Size}}
<div class="teaser-block-{{.Type}} teaser-block-{{.Type}}-{{$size}}">
  {{range .Teasers}}
    <div class="teaser-item">
      <a href="#" target="_blank">
        <img src="http://localhost:8080/uploads/teaser/image/{{.Id}}/thumb_{{$size}}_{{.Image}}">
        <div class="dscr">
          {{.Text}}
        </div>
      </a>
    </div>
  {{end}}
</div>
{{end}}

{{define "css"}}
  <style type="text/css">
    .teaser-block-ver{

    }
      .teaser-block-ver img, .teaser-block-hor img{
        display: block;
      }
      .teaser-block-ver a, .teaser-block-hor a{
        font-size: 12px;
        color: #333;
        text-decoration: none;
      }

    .teaser-block-hor:after{
      content: ".";
      display: block;
      clear: both;
      visibility: hidden;
      line-height: 0;
      height: 0;
    }
    * html .teaser-block-hor {
      height: 1%;
    }

      .teaser-block-hor .teaser-item, .teaser-block-ver .teaser-item{
        margin: 5px;
      }

      .teaser-block-hor .teaser-item{
        float: left;
      }

    .teaser-block-ver-50{
      width: 50px;
    }
    .teaser-block-hor-50{
      width: 100%;
    }
      .teaser-block-ver-50 .teaser-item, .teaser-block-hor-50 .teaser-item{
        width: 50px;
      }


    .teaser-block-ver-100{
      width: 100px;
    }
    .teaser-block-hor-100{
      width: 100%;
    }
      .teaser-block-ver-100 .teaser-item, .teaser-block-hor-100 .teaser-item{
        width: 100px;
      }


    .teaser-block-ver-200{
      width: 200px
    }
    .teaser-block-hor-200{
      width: 100%;
    }

      .teaser-block-ver-200 .teaser-item, .teaser-block-hor-200 .teaser-item{
        width: 200px;
      }

  </style>
{{end}}


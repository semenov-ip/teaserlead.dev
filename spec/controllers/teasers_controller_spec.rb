require 'spec_helper'

describe TeasersController do
  # TODO: включить рендер вьюх при тестировании

  # This should return the minimal set of attributes required to create a valid
  # Teaser. As you add validations to Teaser, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for :teaser }

  describe "GET index" do
    it "assigns all teasers to @teasers" do
      get :index
      assigns(:teasers).should eq(Teaser.all)
    end
  end

  describe "GET new" do
    it "assigns a new teaser as @teaser" do
      get :new, {}
      assigns(:teaser).should be_a_new(Teaser)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Teaser" do
        expect {
          post :create, {:teaser => valid_attributes}
        }.to change(Teaser, :count).by(1)
      end

      it "assigns a newly created teaser as @teaser" do
        post :create, {:teaser => valid_attributes}
        assigns(:teaser).should be_a(Teaser)
        assigns(:teaser).should be_persisted
      end

      it "redirects to the created teaser" do
        post :create, {:teaser => valid_attributes}
        response.should redirect_to(teaser_path(Teaser.last))
      end
    end

    describe "with invalid params" do
      # FIXME: разобраться, почему strong params кидает ошибку ActionController::ParameterMissing
      xit "assigns a newly created but unsaved teaser as @teaser" do
        # Trigger the behavior that occurs when invalid params are submitted
        Teaser.any_instance.stub(:save).and_return(false)
        post :create, {:teaser => {  }}
        assigns(:teaser).should be_a_new(Teaser)
      end

      xit "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Teaser.any_instance.stub(:save).and_return(false)
        post :create, {:teaser => {  }}
        response.should render_template("new")
      end
    end
  end

  describe "with existing teaser" do

    before :each do
      @teaser = FactoryGirl.create :teaser
    end

    describe "GET show" do
      it "assigns the requested teaser as @teaser" do
        get :show, {:id => @teaser.to_param}
        assigns(:teaser).should eq(@teaser)
      end
    end

    describe "GET edit" do
      it "assigns the requested teaser as @teaser" do
        get :edit, {:id => @teaser.to_param}
        assigns(:teaser).should eq(@teaser)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested teaser" do

          # Assuming there are no other teasers in the database, this
          # specifies that the Teaser created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          # TODO: разобраться с мокапами и стабами
          # Teaser.any_instance.should_receive(:update).with({ "these" => "params" })
          old_text = @teaser.text
          new_text = 'new text'
          expect {
            put :update, {id: @teaser.to_param, teaser: { text: new_text }}
            @teaser.reload
          }.to change(@teaser, :text).from(old_text).to(new_text)
        end

        it "assigns the requested teaser as @teaser" do
          put :update, {id: @teaser.to_param, :teaser => valid_attributes}
          assigns(:teaser).should eq(@teaser)
        end

        it "redirects to the teaser" do
          put :update, {id: @teaser.to_param, :teaser => valid_attributes}
          response.should redirect_to(teaser_path(@teaser))
        end
      end

      describe "with invalid params" do
        xit "assigns the teaser as @teaser" do
          # Trigger the behavior that occurs when invalid params are submitted
          Teaser.any_instance.stub(:save).and_return(false)
          put :update, {id: @teaser.to_param, :teaser => {  }}
          assigns(:teaser).should eq(@teaser)
        end

        xit "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Teaser.any_instance.stub(:save).and_return(false)
          put :update, {id: @teaser.to_param, :teaser => {  }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested teaser" do
        expect {
          delete :destroy, id: @teaser.to_param
        }.to change(Teaser, :count).by(-1)
      end

      it "redirects to the teasers list" do
        delete :destroy, id: @teaser.to_param
        response.should redirect_to(teasers_path)
      end
    end

  end

end

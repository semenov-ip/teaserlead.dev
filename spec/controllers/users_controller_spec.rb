require 'spec_helper'

describe UsersController do
  # TODO: включить рендер вьюх при тестировании

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for :user }

  describe "guest user actions" do

    describe "GET show" do
      it "redirects to a root path" do
        pending "Запустить после добавления acl"
        user = FactoryGirl.create :user
        expect {
          get :show, {:id => user.to_param}
        }.to redirect_to root_path
      end
    end

    describe "GET new" do
      it "assigns a new user as @user" do
        get :new, {}
        assigns(:user).should be_a_new(User)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new User" do
          expect {
            post :create, {:user => valid_attributes}
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          post :create, {:user => valid_attributes}
          assigns(:user).should be_a(User)
          assigns(:user).should be_persisted
        end

        it "redirects to the created user" do
          post :create, {:user => valid_attributes}
          response.should redirect_to(user_path)
        end
      end

      describe "with invalid params" do
        # FIXME: разобраться, почему strong params кидает ошибку ActionController::ParameterMissing
        xit "assigns a newly created but unsaved user as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => {  }}
          assigns(:user).should be_a_new(User)
        end

        xit "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          post :create, {:user => {  }}
          response.should render_template("new")
        end
      end
    end
  end

  describe "authenticated user actions" do

    before :each do
      @user = FactoryGirl.create :user
      sign_in @user
    end


    describe "GET show" do
      it "assigns the requested user as @user" do
        get :show
        assigns(:user).should eq(@user)
      end
    end

    describe "GET edit" do
      it "assigns the requested user as @user" do
        get :edit, {:id => @user.to_param}
        assigns(:user).should eq(@user)
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested user" do

          # Assuming there are no other users in the database, this
          # specifies that the User created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          # TODO: разобраться с мокапами и стабами
          # User.any_instance.should_receive(:update).with({ "these" => "params" })
          old_email = @user.email
          new_email = 'test2@example.com'
          expect {
            put :update, {user: { email: new_email }}
            @user.reload
          }.to change(@user, :email).from(old_email).to(new_email)
        end

        it "assigns the requested user as @user" do
          put :update, {:user => valid_attributes}
          assigns(:user).should eq(@user)
        end

        it "redirects to the user" do
          put :update, {:user => valid_attributes}
          response.should redirect_to(user_path)
        end
      end

      describe "with invalid params" do
        xit "assigns the user as @user" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:user => {  }}
          assigns(:user).should eq(@user)
        end

        xit "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          User.any_instance.stub(:save).and_return(false)
          put :update, {:user => {  }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested user" do
        expect {
          delete :destroy
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        delete :destroy
        response.should redirect_to(root_path)
      end
    end

  end

end

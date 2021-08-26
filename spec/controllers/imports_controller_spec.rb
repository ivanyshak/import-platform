require 'rails_helper'

describe ImportsController, type: :controller do
  describe "GET imports" do
    let(:import) { create(:import) }

    it "assigns imports" do
      get :index
      expect(assigns(:imports)).to eq([import])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET import/:id" do
    let(:import) { create(:import) }

    it "renders the show template" do
      get :show, params: { id: import.id }
      expect(response).to render_template("show")
    end
  end

  describe 'GET import/:id/edit' do
    let(:import) { create(:import) }

    it "renders the show template" do
      get :edit, params: { id: import.id }
      expect(response).to render_template("edit")
    end
  end

  describe 'PUT /import/:id' do
    let(:import) { create(:import) }
    let(:attr) { { title: 'Test Form' } }

    context 'check success update' do
      before(:each) do
        put :update, params: { id: import.id, import: attr }
        import.reload
      end

      it 'returns status code 204' do
        expect(import.title).to eq(attr[:title])
      end

      it 'will redirect to root path' do
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe 'CREATE /import' do
    let(:attr) { { title: 'Test Form' } }

    context 'check success create' do
      before(:each) do
        post :create, params: { import: attr }
      end

      it "should increment import count" do
        expect { post :create, params: { import: attr } }.to change(Import, :count).by(1)
      end

      it 'will redirect to root path' do
        expect(response).to redirect_to(import_path(Import.last))
      end
    end
  end

  describe 'DELETE /import/:id' do
    let!(:import) { create(:import) }

    context 'check success delete' do
      it "should decrement import count" do
        expect { delete :destroy, params: { id: import.id } }.to change { Import.count }.by(-1)
      end
    end
  end
end

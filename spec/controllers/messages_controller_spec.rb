require 'rails_helper'

describe MessagesController do
  #  letを利用してテスト中使用するインスタンスを定義
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe "#index" do
    # ログインしている場合
    context "ログインしている場合" do
      before do
        login user
        get :index, params: { group_id: group.id }
      end
      # アクション内で定義しているインスタンス変数があるか
      it "@messageに期待した値が入っていること" do
        expect(assigns(:message)).to be_a_new(Message)
      end
      it "@groupに期待した値が入っていること" do
        expect(assigns(:group)).to eq group
      end
      # 該当するビューが描画されているか
      it "index.html.hamlに遷移すること" do
        expect(response).to render_template :index
      end
    end
    # ログインしていない場合
    context "ログインしていない場合" do
      before do
        get :index, params: { group_id: group.id }
      end
      # 意図したビューにリダイレクトできているか
      it 'ログイン画面にリダイレクトすること' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "#create" do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    #ログインしている場合
    context "ログインしている場合" do
      before do
        login user
      end
      #保存に成功した場合
      context "保存に成功した場合" do
        subject {
          post :create,
          params: params
        }
        #メッセージの保存ができていること
        it "messageを保存すること" do
          expect{ subject }.to change(Message, :count).by(1)
        end
        #意図した画面にリダイレクトすること
        it "group_messages_pathへリダイレクトすること" do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end
      #保存に失敗した場合
      context "保存に失敗した場合" do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }
        subject {
          post :create,
          params: invalid_params
        }
        #メッセージの保存が行われなかったこと
        it "messageを保存しないこと" do
          expect{ subject }.not_to change(Message, :count)
        end
        #意図したビューが描画されていること
        it "index.html.hamlに遷移すること" do
          subject
          expect(response).to render_template :index
        end
      end
    end
    #ログインしていない場合
    context "ログインしていない場合" do
      before do
        get :create, params: params
      end
      #意図した画面にリダイレクトできていること
  it "new.html.hamlに遷移すること" do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
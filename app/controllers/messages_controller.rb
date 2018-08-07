class MessagesController < ApplicationController
  
  def index
    @messages = Message.all
  end
  
  def show
    @message = Message.find_by(id: params[:id])
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    
    if @message.save
      flash[:sccress] = "Messageが正常に投稿されました。"
      redirect_to @message
      #redirect_toになぜインスタンス変数？
      #redirect_toが実行されたときに@messageはidのもつ特定のレコードになる
    else
      flash.now[:danger] = "Messageが投稿されませんでした。"
      render :new
    end
  end
  
  def edit
    @message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])
    
    if @message.update(message_params)
      flash[:success] = "Messageは正常に更新されました。"
      redirect_to @message
    else
      flash.now[:danger] = "Mesageは更新されませんでした。"
      render :edit
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    
    flash[:success] = "Messageは正常に削除されました"
    redirect_to messages_url
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
    #params.require(:message)とすることでmessageの中身だけ取得することができる。
    #ここでのmessageは params[:content] である。
    #ちなみにparams.require(:controller)とするとmessagesが取得できる。
    #ちなみにparams.require(:action)とするとcreateが取得できる。
    #params.require(:message)のままでは全てのハッシュ値を取得しているだけ
    #permitの引数に取得したい値を指定することでそのパラメーターだけ取得することができる。
  end

end

class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    
    if @message.save
      flash[:success] = 'Taskを作成しました'
      redirect_to @message
    else
      flash.now[:danger] = "Taskを作成できませんでした"
      render :new
    end
  end
  
  def edit
    @message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])
    
    if @message.update(message_params)
      flash[:success] = 'Taskを更新しました'
      redirect_to @message
    else
      flash.now[:danger] = 'Taskを更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to messages_url
  end
  
end


private

def message_params
  params.require(:message).permit(:content)
end
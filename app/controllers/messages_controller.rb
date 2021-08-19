class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update destroy]

  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages
  end

  def new
    @room = Room.find(params[:room_id])
    @message = @room.messages.new
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html do
          flash[:success] = 'Message created successfully.'
          redirect_to @room
        end
      else
        render :new
      end
    end
  end

  def edit; end

  def update
    if @message.update(message_params)
      flash[:notice] = 'Updated message successfully.'
      redirect_to @room
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    flash[:error] = 'Message deleted successfully.'
    redirect_to @room
  end

  def set_message
    @room = Room.find(params[:room_id])
    @message = @room.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

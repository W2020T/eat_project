class MessagesController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content,
                                                                :room_id).merge(user_id: current_user.id))
      @room = @message.room
      if @message.save

        @receiver = Entry.where(room_id: @room.id).where.not(user_id: current_user.id).find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
          visited_id: @receiver.user_id,
          room_id: @room.id,
          message_id: @message.id
        )
        notification.save if notification.valid?

        redirect_to(room_path(@message.room_id))
      else
        flash[:alert] = 'メッセージ送信に失敗しました。'
        redirect_to(room_path(@message.room_id))
      end
    else
      flash[:alert] = 'メッセージ送信に失敗しました。'
    end
    redirect_to("/rooms/#{@message.room_id}")
  end
end

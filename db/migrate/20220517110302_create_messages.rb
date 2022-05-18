class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content

      t.references :room, foreign_key: true

      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :messages, :from_id
    add_index :messages, :to_id
  end

  def create
    @message = current_user.outgoing_messages.build(message_params)
    @message.to_id = params[:id]
    @message.save
    @messages = Message.where('from_id IN (:ids) AND to_id IN (:ids)', ids: @ids)
    respond_to do |format|
      format.html { redirect_to messages_urL(@to_user) }
      format.js { render 'create' }
    end
  end
end

class RoomMessagesController < ApplicationController

  before_action :load_entities, only: [:create]

  def create
    @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                       message: params.dig(:room_message, :message)
    RoomChannel.broadcast_to @room, @room_message
  end

  def index
    @room_messages = RoomMessage.all
    render json: @room_messages
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end

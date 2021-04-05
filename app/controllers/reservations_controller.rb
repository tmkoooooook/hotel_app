class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show, :index, :destroy]
    def index
       @reservation = Reservation.where(user_id: current_user.id)
       @room = current_user.rooms
    end
    def new
        @reservation = Reservation.new(reservation_params)
        @room = Room.find(params[:reservation][:room_id])
        reservation_ensure
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @room = Room.find_by(id: @reservation.room_id)
        if @reservation.save
            flash[:notice] = "ルームの予約が完了しました"
            redirect_to action:"show", id: @reservation.id
        else
            render "new"
        end
    end

    def show
        @reservation = Reservation.find(params[:id])
        @room = Room.find_by(id: @reservation.room_id)
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        flash[:notice] = "削除しました"
        redirect_to reservations_path
    end
    def reservation_ensure
      if @reservation.end_date == nil || @reservation.start_date == nil || @reservation.person_num == nil
        flash[:notice] = "全て入力してください"
        redirect_to controller: "rooms", action: "show",id: @room.id
      else
        @days = (@reservation.end_date - @reservation.start_date)/(24 * 60 * 60)
        if @days <= 0
          flash[:notice] = "終了日を開始日以降に設定してください"
          redirect_to controller: "rooms", action: "show",id: @room.id
        end
        total = @room.room_money * @days * @reservation.person_num
        @reservation.total = total.to_i
      end
    end

    private
    def reservation_params
        params.require(:reservation).permit(:start_date, :end_date, :person_num, :user_id, :room_id, :total)
    end
end

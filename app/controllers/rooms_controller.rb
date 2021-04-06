class RoomsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :posts, :destroy]

    def index
        @q = Room.ransack(params[:q])
        @rooms = @q.result(distinct: true)
    end

    def new
        @room = Room.new
    end

    def create
        @room = Room.new(room_params)
        @room.user_id = current_user.id
        if @room.save
            flash[:notice] = "ルーム登録が完了しました"
            redirect_to action: "show",id:@room.id
        else
            render "new"
        end
    end

    def show
        @room = Room.find(params[:id])
        @reservation =Reservation.new
    end

    def edit

    end

    def update

    end

    def destroy
      @room = Room.find(params[:id])
      @room.destroy
      flash[:notice] = "削除しました"
      redirect_to rooms_posts_path
    end

    def search
        @q = Room.search(search_params)
        @room = @q.result(distinct: true)
    end
    def posts
        @room = Room.where(user_id: current_user.id)
    end

    private
    def search_params
        params.require(:q).permit!
    end

    def room_params
        params.require(:room).permit(:room_name, :room_introduction, :room_money, :room_address, :room_image)
    end

end

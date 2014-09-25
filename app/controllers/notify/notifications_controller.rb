module Notify
  class NotificationsController < Notify::ApplicationController
    layout false

    def index
      @notifications = notifiable.notifications.ordered.page(params[:page])

      respond_to do |format|
        format.html
        format.json { render json: @notifications }
      end
    end

    def show
      @notification = notifiable.notifications.find(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @notification }
      end
    end

    def read
      notification = notifiable.notifications.find(params[:id])
      notification.read!

      respond_to do |format|
        format.html { redirect_to action: "index" }
        format.json { render json: notification }
      end
    end

    def read_all
      unread_notifications = notifiable.notifications.unread
      unread_notifications.each(&:read!)

      respond_to do |format|
        format.html { redirect_to action: "index" }
        format.json { render json: unread_notifications }
      end
    end

    private

    def notifiable
      @notifiable ||= if (method = Notify.notifiable_controller_method)
        send(method)
      end
    end
  end
end

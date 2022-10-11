class SubscribersController < ApplicationController
  before_action :set_subscriber, only: %i[ show edit update destroy ]
  # skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :verify_authenticity_token, if: :json_request?
  protect_from_forgery with: :null_session, only: [:create]
  # API POST REGUEST ALLOW CROSS DOMAIN
  # before_filter :cor
  # def cor
  #   headers["Access-Control-Allow-Origin"]  = "*"
  #   headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
  #   headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
  #   head(:ok) if request.request_method == "OPTIONS"
  # end

  # GET /subscribers or /subscribers.json
  def index
    @subscribers = Subscriber.all

    respond_to do |format|
      format.html
      format.json { render json: @subscribers }
    end
  end

  # GET /subscribers/1 or /subscribers/1.json
  def show
  end

  # GET /subscribers/new
  def new
    # get new subscriber from json request from client and save it to database
    # @param [String] subscribers
    # @param [String] email
    # @param [String] name
    # @param [String] status
    @subscriber = Subscriber.new
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers or /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        format.html { redirect_to subscriber_url(@subscriber), notice: "Subscriber was successfully created." }
        format.json { render json: @subscriber.status, status: :created, location: @subscriber }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscribers/1 or /subscribers/1.json
  def update
    respond_to do |format|
      if @subscriber.update(subscriber_params)
        format.html { redirect_to subscriber_url(@subscriber), notice: "Subscriber was successfully updated." }
        format.json {}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1 or /subscribers/1.json
  def destroy
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to subscribers_url, notice: "Subscriber was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end

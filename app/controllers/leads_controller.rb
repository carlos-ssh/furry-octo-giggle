class LeadsController < ApplicationController
  before_action :set_lead, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, if: :json_request?
  protect_from_forgery with: :null_session, only: [:create]

  # GET /leads or /leads.json
  def index
    @leads = Lead.all.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.json { render json: @subscribers }
    end
  end

  # GET /leads/1 or /leads/1.json
  def show
  end

  def import
    Lead.import(params[:file])
    redirect_to leads_url, notice: "Leads importados."
  end

  # GET /leads/new
  def new
    @lead = Lead.new

    respond_to do |format|
      if @lead.save
        format.html { render :new, notice: "Lead was successfully created." }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads or /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to lead_url(@lead), notice: "Lead was successfully created." }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to lead_url(@lead), notice: "Lead was successfully updated." }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1 or /leads/1.json
  def destroy
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_url, notice: "Lead was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :email, :phone, :note)
    end
end

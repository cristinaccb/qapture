class QrCodesController < ApplicationController
  def index
    @qr_codes = QrCode.all
  end

  def show
    @qr_code = QrCode.find(params[:id])
  end

  def new
    @qr_code = QrCode.new
  end

  def create
    @qr_code = QrCode.new(qr_code_params)
    if @qr_code.save
      redirect_to @qr_code, notice: 'QrCode was successfully created.'
    else
      render :new
    end
  end

  def edit
    @qr_code = QrCode.find(params[:id])
  end

  def update
    @qr_code = QrCode.find(params[:id])
    if @qr_code.update(qr_code_params)
      redirect_to @qr_code, notice: 'QrCode was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @qr_code = QrCode.find(params[:id])
    @qr_code.destroy
    redirect_to qr_codes_url, notice: 'QrCode was successfully destroyed.'
  end

  private

  def qr_code_params
    params.require(:qr_code).permit(:event_id, :qrCodeUrl)
  end
end

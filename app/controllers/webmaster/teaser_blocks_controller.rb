class Webmaster::TeaserBlocksController < Webmaster::ApplicationController
  before_action :set_teaser_block, only: [:show, :edit, :update, :destroy]

  # GET /teaser_blocks
  # GET /teaser_blocks.json
  def index
    @teaser_blocks = TeaserBlock.all
  end

  # GET /teaser_blocks/1
  # GET /teaser_blocks/1.json
  def show
  end

  # GET /teaser_blocks/new
  def new
    @teaser_block = TeaserBlock.new
  end

  # GET /teaser_blocks/1/edit
  def edit
  end

  # POST /teaser_blocks
  # POST /teaser_blocks.json
  def create
    @teaser_block = TeaserBlock.new(teaser_block_params)

    respond_to do |format|
      if @teaser_block.save
        format.html { redirect_to @teaser_block, notice: 'Teaser block was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teaser_block }
      else
        format.html { render action: 'new' }
        format.json { render json: @teaser_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teaser_blocks/1
  # PATCH/PUT /teaser_blocks/1.json
  def update
    respond_to do |format|
      if @teaser_block.update(teaser_block_params)
        format.html { redirect_to @teaser_block, notice: 'Teaser block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @teaser_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teaser_blocks/1
  # DELETE /teaser_blocks/1.json
  def destroy
    @teaser_block.destroy
    respond_to do |format|
      format.html { redirect_to teaser_blocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teaser_block
      @teaser_block = TeaserBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teaser_block_params
      params.require(:teaser_block).permit(:topic, :text_color, :text_encoding, :text_position, :font, :block_size, :block_bg_color, :block_border_color, :block_margin, :block_position, :site_id)
    end
end

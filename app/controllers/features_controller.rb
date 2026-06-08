class FeaturesController < ApplicationController
  def index
    render json: {
      sow_import: SowImporter.available?
    }
  end
end

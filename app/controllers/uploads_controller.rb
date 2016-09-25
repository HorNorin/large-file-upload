class UploadsController < ApplicationController
  def new
  end

  def create
    filename = params[:filename]
    uuid = SecureRandom.uuid
    ext  = File.extname(filename)
    dir  = Rails.root.join('tmp', 'upload').to_s
    FileUtils.mkdir_p(dir) unless File.exist?(dir)

    @upload = Upload.new(
      filename: filename,
      path: File.join(dir, "#{uuid}#{ext}")
    )

    if @upload.save
      render json: { id: @upload.id, uploaded_size: @upload.uploaded_size }
    else
      render json: { error: @upload.errors }
    end
  end

  def chunk_create
    file    = params[:upload]
    @upload = Upload.find_by(id: params[:id])
    @upload.uploaded_size += file.size

    if @upload.save
      File.open(@upload.path, 'ab') { |f| f.write(file.read) }
      render json: { id: @upload.id, uploaded_size: @upload.uploaded_size }
    else
      render json: { error: @upload.errors }, status: 422
    end
  end
end

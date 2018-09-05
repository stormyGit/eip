class DevlogsController < ApplicationController

  def index
    #authorize Devlog.new
    @devlogs = Devlog.all.order(created_at: :desc)

    if params[:y].present? && params[:m].present?
      @devlogs = @devlogs.where('extract(year from created_at) = ?', params[:y]).where('extract(month from created_at) = ?', params[:m])
    end

    @more_logs = Devlog.all.order(created_at: :desc).pluck("extract(month from created_at)", "extract(year from created_at)").uniq
  end

  def show
    @devlog = Devlog.find_by(id: params[:id])
    @more_logs = Devlog.all.order(created_at: :desc).pluck("extract(month from created_at)", "extract(year from created_at)").uniq
    # authorize @devlog
  end

  def new
    # authorize Devlog.new

  end

  def create
    devlog = Devlog.new
    devlog.assign_attributes(params.require(:devlog).permit([
      :title,
      :short_description,
      :body,
      :user_id
    ]))
    # authorize devlog
    devlog.save!

    redirect_to devlog_path(devlog)
  end

  def edit
    @devlog = Devlog.find_by(id: params[:id])
    # authorize @devlog
  end

  def update
    devlog = Devlog.find_by(id: params[:id])
    devlog.assign_attributes(params.require(:devlog).permit([
      :title,
      :short_description,
      :body,
      :user_id
    ]))
    # authorize devlog
    devlog.save!

    redirect_to devlog_path(devlog)
  end

  def destroy
    devlog = Devlog.find_by(id: params[:id])
    # authorize devlog
    devlog.destroy!

    redirect_to devlogs_path
  end

end

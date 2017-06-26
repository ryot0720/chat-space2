class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to root_path(@group)
      flash[:notice] = "Group Created!"
    else
      render :new
      flash[:alert] = "Missed group-creation"
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to root_path(@group)
      flash[:notice] = "Group Updated!"
    else
      render :edit
      flash[:alert] = "Missed update"
    end
  end

private
  def set_group
    @group = Group.includes(:users).find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end
end

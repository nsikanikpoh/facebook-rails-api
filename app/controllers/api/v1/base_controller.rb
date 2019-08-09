class Api::V1::BaseController < ApplicationController
  respond_to :json
   after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  before_action :load_resource, except: :index

  def create
    authorize(instance)
    instance.attributes = self.send("#{controller_name.singularize}_params".to_sym)
    if instance.save && instance.valid?
      render json: instance, serializer: serializer
    else
      render json: instance, serializer: serializer, status: :unprocessable_entity
    end
  end

  def show
    authorize(instance)
    render json: instance, serializer: serializer
  end

  def update
    authorize(instance)
    if instance.update_attributes(self.send("#{controller_name.singularize}_params".to_sym)) && instance.valid?
      render json: instance, serializer: serializer
    else
      render json: instance, serializer: serializer, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(instance)
    instance.destroy
    head :no_content
  end

  private

  def load_resource
    klass = (controller_name.singularize.classify.constantize rescue nil)
    klass ||= (controller_path.classify.constantize rescue nil)

    klass_name = (klass.name.demodulize.underscore rescue nil)
    @resource_scope ||= klass
    case action_name
    when 'index' then
      eval("@#{klass_name.pluralize} = @resource_scope.all")
    when 'show', 'edit', 'update', 'destroy' then
      eval("@#{klass_name} = @resource_scope.find(params[:id])")
    when 'create' then
      eval("@#{klass_name} = @resource_scope.new(#{klass_name}_params)")
    end
  end

  def instance
    @instance ||= eval("@#{controller_name.singularize}")
  end

  def instances
    @instances ||= eval("@#{controller_name}")
  end

  def serializer
    @serializer ||= "Api::V1::#{controller_name.singularize.classify}Serializer".constantize
  end


end

<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  before_action :get_user_role, only:[:index]

  # GET <%= route_url %>
  def index

    [:rq_begin_sc,:rq_end_sc,:check_sc].each do |k|
      session[k]=params[k]||session[k]
      session[k]=nil if params[:clear_params]=='1'
    end

    @query = <%= orm_class.all(class_name) %>

    #查询条件
    #@query = @query.where("rq >= ?", session[:rq_begin_sc]) unless session[:rq_begin_sc].blank?
    #@query = @query.where("rq <= ?", session[:rq_end_sc]) unless session[:rq_end_sc].blank?
    #@query = @query.where("regno like ?", '%'+session[:regno_sc]+'%') unless session[:regno_sc].blank?

    @<%= plural_table_name %>= @query.order(id: :desc).paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html
      format.xls {
        between_day = 0
          if !session[:rq_begin_sc].blank? and !session[:rq_end_sc].blank?
             d2 = Date.parse(session[:rq_end_sc])
             d1 = Date.parse(session[:rq_begin_sc])
             between_day = (d2 - d1).to_i
          end
          if @query.size > 500 or between_day > 60
            redirect_to <%= plural_table_name %>_path,alert: '请设置日期缩小导出范围。'
          else
            render xls: @query
          end
        }
    end
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>


    #自定义验证（根据实际修改，除非必要，验证一律写在model中）
    # if @<%= singular_table_name %>.status != '集团内部车' and @<%= singular_table_name %>.saler_id.blank?
    #   @<%= singular_table_name %>.errors.add(:sales_id,'销售顾问不能为空！')
    # end


    if @<%= orm_instance.save %>
      redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} 新增成功.'" %>
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    
    #自定义验证（根据实际修改，除非必要，验证一律写在model中）
    # if <%= singular_table_name %>_params[:is_adjust] == '是' and <%= singular_table_name %>_params[:think_distance].to_i<=0
    #   @<%= singular_table_name %>.errors.add(:think_distance,'预估里程不能为空！')
    # end
    # if @<%= singular_table_name %>.errors.size>0
    #   render :edit
    # else
    #    redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} 修改成功.'" %>
    # end


    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} 修改成功.'" %>
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} 删除成功.'" %>
  end

  #获取权限
  def get_user_role
    @is_admin=current_user.has_role? :admin
    @is_es_sale=current_user.has_role? :es_sale
    @is_es_saleclerk=current_user.has_role? :es_saleclerk
    @is_es_admin=current_user.has_role? :es_admin
    @is_finclerk=current_user.has_role? :es_finclerk
    @is_es_cw=current_user.has_role? :es_cw
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params.fetch(:<%= singular_table_name %>, {})
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit!
      <%- end -%>
    end
end
<% end -%>


#常用的返回方法

#render plain: "OK"    #用于把没有标记语言的纯文本发给浏览器
#render status: 200    #生成的响应附加正确的 HTTP 状态码
#render layout: false  #不使用布局

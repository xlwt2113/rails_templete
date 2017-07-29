<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>

end
<% end -%>


####################常用代码，根据实际情况增加####################################


# 关联关系
# belongs_to
# has_one
# has_many
# has_many :through
# has_one :through
# has_and_belongs_to_many


#验证
# validates_presence_of :es_pg_id, :message => "未选择二手车评估单!"
# validates :price, numericality: {less_than:9999999, :message => "收购价格格式不正确!"}
# validates :gh_name, length: { maximum: 30 ,:message => "过户名称太长!"}
# validates :key, numericality: {greater_than:0, :message => "钥匙数量不能为0!"}
# validates_format_of :customer_mobile, :with => /\A1[3|4|5|7|8]\d{9}\z/, :message => "手机格式录入错误"
# validates_format_of :regno, :with => /[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}/, :message => "车牌号格式错误"
# validates_format_of :vin, :with => /\A[a-zA-Z0-9]{17}\z/, :message => "车架号格式录入错误"



#验证之前执行的自定义验证样例（对于controller中新增和更新方法中特殊的验证，尽量在此处实现）
# before_validation :check_self_validat

# def check_self_validat
#   if self.id.blank?
#     count = <%= class_name %>.where(" dict_id =? and val = ? ",self.dict_id,self.val).count()
#     self.errors.add(:val,'已经存在添加的属性值，请更改！') if count > 0
#   else
#     count = <%= class_name %>.where(" dict_id =? and val = ? and id != ?",self.dict_id,self.val,self.id).count()
#     self.errors.add(:val,'修改的属性值已经存在，请更改！') if count > 0
#   end
# end


#各种回调方法名称
# 3.1 创建对象
# before_validation
# after_validation
# before_save
# around_save
# before_create
# around_create
# after_create
# after_save
# after_commit/after_rollback

# 3.2 更新对象
# before_validation
# after_validation
# before_save
# around_save
# before_update
# around_update
# after_update
# after_save
# after_commit/after_rollback

# 3.3 删除对象
# before_destroy
# around_destroy
# after_destroy
# after_commit/after_rollback
# 编辑的类
class Editor < ActiveRecord::Base
  enum status: [:活跃, :已归档]
  has_many :guandians
  has_many :changces
  has_many :pingces

  #根据输入的作者名，和编辑名进行比对，如无此编辑则认为是新作者
  def self.findauthor(name, c_at)
    self.find_or_create_by(name: name) do |editor|
      editor.first_at = c_at
      editor.last_at = c_at
    end
  end

  #根据输入的作者名，和编辑名进行比对，如无此编辑则认为是新作者,针对长测
  def self.findauthorforchangce(name, c_at)
    self.find_or_create_by(name: name) do |editor|
      editor.cc_first_at = c_at
      editor.cc_last_at = c_at
    end
  end

  #根据输入的作者名，和编辑名进行比对，如无此编辑则认为是新作者,针对评车
  def self.findauthorforpingce(name, c_at)
    self.find_or_create_by(name: name) do |editor|
      editor.pc_first_at = c_at
      editor.pc_last_at = c_at
    end
  end

  # 修改观点计数，同时根据时间戳修改编辑出现的最早和最晚时间
  def guandianjia(c_at)
    self.guandiancount += 1
    self.first_at = c_at if (self.first_at.blank? || self.first_at > c_at)
    self.last_at = c_at if (self.last_at.blank? || self.last_at < c_at)
    self.save

  end

  # 修改长测计数，同时根据时间戳修改编辑出现的最早和最晚时间
  def changcejia(c_at)
    self.changcecount += 1
    self.cc_first_at = c_at if (self.cc_first_at.blank? || self.cc_first_at > c_at)
    self.cc_last_at = c_at if (self.cc_last_at.blank? || self.cc_last_at < c_at)
    self.save
  end

  # 修改评测计数，同时根据时间戳修改编辑出现的最早和最晚时间
  def pingcejia(c_at)
    self.pingcecount += 1
    self.pc_first_at = c_at if (self.pc_first_at.blank? || self.pc_first_at > c_at)
    self.pc_last_at = c_at if (self.pc_last_at.blank? || self.pc_last_at < c_at)
    self.save
  end

  #概要显示编辑们的信息
  def self.digest
    Editor.order(changcecount: :desc,last_at: :desc).each do |e|
      #puts "#{e.name},\t长测文章数: #{e.changcecount},  长测最后时间: #{e.cc_last_at.to_s[0..9]}, 长测初发时间: #{e.cc_first_at.to_s[0..9]}" +
      #"\t观点文章数: #{e.guandiancount}, 观点最后时间: #{e.last_at.to_s[0..9]}, 观点初发时间: #{e.first_at.to_s[0..9]}"
    end
  end

end

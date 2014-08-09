# 编辑的类
class Editor < ActiveRecord::Base
  has_many :guandians

  #根据输入的作者名，和编辑名进行比对，如无此编辑则认为是新作者
  def self.findauthor(name, c_at)
    self.find_or_create_by(name: name) do |editor|
      editor.first_at = c_at
      editor.last_at = c_at
    end
  end

  # 修改观点计数，同时根据时间戳修改编辑出现的最早和最晚时间
  def guandianjia(c_at)
    self.guandiancount += 1
    self.first_at = c_at if (self.first_at > c_at)
    self.last_at = c_at if (self.last_at < c_at)
    self.save

  end

  #概要显示编辑们的信息
  def self.digest
    Editor.order(last_at: :desc).each do |e|
      puts "#{e.name},\t#{e.guandiancount}, 观点最后时间: #{e.last_at.to_s[0..9]}, 观点初发时间: #{e.first_at.to_s[0..9]}"
    end
    nil
  end

end

module EditorsHelper
  #修改的表单形成
  def xiugai(ed)
    form_tag("/editors/status/#{ed.id}", remote: true, class: :fxg) do 
      select_tag "status", options_for_select(["活跃", "已归档"], ed.status)
    end
  end
  
end

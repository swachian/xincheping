module ApplicationHelper
    def riqi(date)
        date.to_s[0..9] if !date.blank?
    end
end

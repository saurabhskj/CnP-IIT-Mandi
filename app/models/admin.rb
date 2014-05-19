class Admin < User
  # attr_accessible :title, :body

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |student|
        csv << student.attributes.values_at(*column_names)
      end
    end
  end

  def self.upload_file(file_name, year_id)

  end
end

class Resume < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :name, :student_id, :updated_at

  belongs_to :student

  validates_uniqueness_of :student_id, :scope => :name

  def self.upload(student_id, file_name)
    puts "error: \n\n #{directory = "lib/resumes/#{student_id}"} \n\n"
    path = File.join(directory, file_name)
    #write the file
    File.open(path, "wb") {|file| file.write(file_name)}

    saved = Resume.create(name: file_name, student_id: student_id).save
    unless saved
      cur_resume = Resume.where("name LIKE #{file_name}% and student_id = #{student_id}")[0]
      Resume.update(cur_resume.id, updated_id: Time.now)
    end

  end

  def self.search(student_id, name)
    if name
      find(:all, :conditions => ['name LIKE ? AND student_id = ?', "%#{name}%", "#{student_id}"])
    else
      find(:all, :conditions => ['student_id = ?', "#{student_id}"])
    end
  end

end

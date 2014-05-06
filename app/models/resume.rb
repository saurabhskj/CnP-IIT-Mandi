class Resume < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.upload(student_id, file_name)
    puts "error: \n\n #{directory = "lib/resumes/#{student_id}"} \n\n"
    path = File.join(directory, file_name)
    #write the file
    File.open(path, "wb") {|file| file.write(file_name)}
  end

end

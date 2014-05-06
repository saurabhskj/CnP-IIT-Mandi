class DataFile < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.save(file_name)
   # name = upload['datafile'].original_filename
    directory = "lib/resumes"
    #create file path

    path = File.join(directory, file_name)

    #write the file
    File.open(path, "wb") {
      |f| f.write(file_name)
    }
  end
end

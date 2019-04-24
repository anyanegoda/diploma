class FilesExcel < ApplicationRecord
  belongs_to :user, optional: true
  mount_uploader :input_file, FileUploader
  mount_uploader :output_file, FileUploader
end

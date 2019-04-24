json.extract! subject, :id, :subject_name, :course, :semester, :created_at, :updated_at
json.url subject_url(subject, format: :json)

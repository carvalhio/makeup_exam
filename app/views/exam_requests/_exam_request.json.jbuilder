json.extract! exam_request, :id, :student_id, :exam_date, :status, :created_at, :updated_at
json.url exam_request_url(exam_request, format: :json)

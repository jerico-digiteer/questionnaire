json.extract! response, :id, :questionnaire_id, :question_id, :response_text, :created_at, :updated_at
json.url response_url(response, format: :json)

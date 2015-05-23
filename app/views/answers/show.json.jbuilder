json.extract! @question, :id, :body
json.extract! @answer, :id, :body, :created_at, :updated_at

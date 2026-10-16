require "test_helper"

class ApiStudentsTest < ActionDispatch::IntegrationTest
  test "GET show retorna 200 para um aluno existente" do
    student = students(:one)

    get "/api/v1/students/#{student.id}"

    assert_response :success
  end
end

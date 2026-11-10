require "test_helper"

class ApiStudentsTest < ActionDispatch::IntegrationTest
  test "GET show retorna os dados de um aluno existente" do
    student = students(:one)

    get "/api/v1/students/#{student.id}"

    assert_response :success

    response_body = response.parsed_body

    assert_equal student.id, response_body["id"]
    assert_equal student.name, response_body["name"]
    assert_equal student.aee, response_body["aee"]

    assert_equal student.school_class.grade,
                 response_body.dig("school_class", "grade")

    assert_equal student.school_class.identifier,
                 response_body.dig("school_class", "identifier")

    assert_equal student.school_class.shift,
                 response_body.dig("school_class", "shift")
  end

  test "GET index retorna a lista de alunos com estrutura padronizada" do
    get "/api/v1/students"

    assert_response :success

    response_body = response.parsed_body

    assert_kind_of Array, response_body
    assert response_body.any?

    student_data = response_body.first

    assert_includes student_data.keys, "id"
    assert_includes student_data.keys, "name"
    assert_includes student_data.keys, "aee"
    assert_kind_of Hash, student_data["school_class"]

    assert_includes student_data["school_class"].keys, "grade"
    assert_includes student_data["school_class"].keys, "identifier"
    assert_includes student_data["school_class"].keys, "shift"
  end

  test "POST create cadastra um aluno com dados válidos" do
    school_class = students(:one).school_class

    assert_difference("Student.count", 1) do
      post "/api/v1/students",
          params: {
            student: {
              name: "ALUNO TESTE INTEGRAÇÃO",
              school_class_id: school_class.id,
              aee: false
            }
          },
          as: :json
    end

    assert_response :created

    response_body = response.parsed_body

    assert_equal "ALUNO TESTE INTEGRAÇÃO", response_body["name"]
    assert_equal school_class.id, response_body["school_class_id"]
    assert_equal false, response_body["aee"]
  end

  test "POST create retorna erro 422 quando o nome está vazio" do
    assert_no_difference("Student.count") do
      post "/api/v1/students",
          params: {
            student: {
              name: "",
              school_class_id: students(:one).school_class_id,
              aee: false
            }
          },
          as: :json
    end

    assert_response :unprocessable_content

    response_body = response.parsed_body

    assert_equal "validation_error", response_body.dig("error", "code")
    assert_includes response_body.dig("error", "details", "name"), "can't be blank"
  end

  test "PATCH update atualiza os dados de um aluno" do
    student = students(:one)

    patch "/api/v1/students/#{student.id}",
          params: {
            student: {
              name: "ALUNO ATUALIZADO"
            }
          },
          as: :json

    assert_response :success

    student.reload

    assert_equal "ALUNO ATUALIZADO", student.name
    assert_equal "ALUNO ATUALIZADO", response.parsed_body["name"]
  end

  test "PATCH update retorna erro 422 quando o nome está vazio" do
    student = students(:one)
    original_name = student.name

    patch "/api/v1/students/#{student.id}",
          params: {
            student: {
              name: ""
            }
          },
          as: :json

    assert_response :unprocessable_content

    student.reload

    assert_equal original_name, student.name

    response_body = response.parsed_body

    assert_equal "validation_error", response_body.dig("error", "code")
    assert_includes response_body.dig("error", "details", "name"), "can't be blank"
  end

  test "DELETE destroy exclui um aluno existente" do
    student = students(:one)

    assert_difference("Student.count", -1) do
      delete "/api/v1/students/#{student.id}"
    end

    assert_response :no_content

    assert_raises(ActiveRecord::RecordNotFound) do
      Student.find(student.id)
    end
  end

  test "DELETE destroy retorna erro 404 para um aluno inexistente" do
    assert_no_difference("Student.count") do
      delete "/api/v1/students/999999"
    end

    assert_response :not_found

    response_body = response.parsed_body

    assert_equal "not_found", response_body.dig("error", "code")
    assert_equal "Registro não encontrado",
                response_body.dig("error", "message")
  end

  test "GET index filtra alunos pelo nome" do
    student = students(:one)

    get "/api/v1/students",
        params: { name: student.name }

    assert_response :success

    response_body = response.parsed_body

    assert response_body.any?

    response_body.each do |student_data|
      assert_includes student_data["name"].downcase,
                      student.name.downcase
    end
  end
end

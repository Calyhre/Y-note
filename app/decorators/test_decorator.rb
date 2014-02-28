class TestDecorator < Draper::Decorator
  delegate_all

  def literal_status_for_current_user
    returned_exam = h.current_user.returned_exam_for_test(object)

    if object.active?
      if returned_exam
        "En cours"
      else
        "À rendre"
      end
    else
      if returned_exam
        "Rendu ( #{ returned_exam.literal_grade } )"
      else
        "Non rendu"
      end
    end
  end

  def icon_status_for_current_user
    returned_exam = h.current_user.returned_exam_for_test(object)

    if object.active?
      if returned_exam
        h.content_tag :i, nil, class: "fa fa-file-text-o"
      else
        h.content_tag :i, nil, class: "fa fa-file-o"
      end
    else
      if returned_exam
        h.content_tag :i, nil, class: "fa fa-check green"
      else
        h.content_tag :i, nil, class: "fa fa-ban"
      end
    end
  end
end

class RenameGroupSubjectToCourse < ActiveRecord::Migration
  def change
    rename_table  :group_subjects, :courses
    rename_column :tests, :group_subject_id, :course_id
  end
end

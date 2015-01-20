require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Task < Hashie::Mash
    class << self
      def create(*contacts, subject: '', description: '')
        contacts = contacts.flatten.uniq.map(&:to_s)
        payload = {
          'subject' => subject,
          'description' => description,
          'contact_ids' => contacts
        }
        response = AgileCRMWrapper.connection.post('tasks', payload)
        new(response.body)
      end

      def add_by_email(email='', subject='')
        payload = {
          "subject" => subject,
          "owner_id" => "5094221490946048",
          "type" => "EMAIL",
          "priority_type" => "NORMAL",
          "status" => "COMPLETED",
        }
        AgileCRMWrapper.connection.post("tasks/email/#{email}", payload)
      end

      def delete(id)
        AgileCRMWrapper.connection.delete("tasks/#{id}")
      end
    end
  end
end

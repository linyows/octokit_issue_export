module Octokit
  class Client
    module IssueExport
      def export_issues(username = nil)
        username = login if username.nil?
        repos(username).each { |repo| export_issues_by_repo(repo) }
        Time.now
      end

      def export_organization_issues(organization)
        org_repos(organization).each { |repo| export_issues_by_repo(repo) }
        Time.now
      end
      alias :export_org_issues :export_organization_issues

      def export_issues_by_repository(repo)
        puts "[#{repo.full_name}]"
        if repo(repo.full_name).has_issues?
          self._dir_for_export = File.join(%w(.) + repo.full_name.split('/'))
          _export_issues_by_repository(repo.full_name)
        else
          puts "- project without issues"
        end
      end
      alias :export_issues_by_repo :export_issues_by_repository

      def _export_issues_by_repository(repo)
        %i(open closed).each { |state|
          page = 1
          loop do
            paged_issues = issues(repo,
              per_page: 100,
              page: page,
              state: state)
            break if paged_issues.empty?
            paged_issues.each { |issue|
              _output_for_export(issue.number, state, issue.comments, issue.title)
              _export_issue(repo, issue)
            }
            page += 1
          end
        }
      end

      def _output_for_export(number, state, comments, title)
        puts <<-OUTPUT.gsub(/\s{10}/, '').gsub(/\n/, '')
          - #{"##{number}".rjust(4)},
          state: #{state.to_s.rjust(6)},
          comments: #{comments.to_s.rjust(3)},
          title: "#{title.to_s}"
        OUTPUT
      end

      def _export_issue(repo, issue)
        data = _dump_resources(issue)

        comment_data = []
        page = 1
        loop do
          paged_comments = issue_comments(repo,
            issue.number,
            per_page: 100,
            page: page)
          break if paged_comments.empty?
          paged_comments.each { |comment| comment_data << _dump_resources(comment) }
          page += 1
        end

        data.merge!(comment_data: comment_data)
        file = File.join(_dir_for_export, "#{issue.number}.json")
        _export_json(data, file)
      end

      def _dump_resources(resources)
        return resources unless resources.respond_to?(:attrs)
        resources.attrs.each_with_object({}) do |(k,v), result|
          result[k] = v.respond_to?(:attrs) ? v.attrs : v
        end
      end

      def _dir_for_export=(path)
        _mkdir_recursive(path)
        @_dir_for_export = path
      end

      def _dir_for_export
        @_dir_for_export
      end

      def _mkdir_recursive(path)
        return if File.directory?(path)
        parent = File::dirname(path)
        _mkdir_recursive(parent)
        Dir::mkdir(path)
      end

      def _export_json(data, file)
        File.open(file , 'w') { |f| f.write JSON.pretty_generate(data) }
      end
    end
  end
end

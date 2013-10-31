require 'helper'

describe Octokit::Client::IssueExport do
  let(:owner) { 'linyows' }
  let(:organization) { 'rails' }
  let(:repo) { "#{owner}/octokit_issue_export" }

  let(:output_repo) do
    "[#{repo}]"
  end

  let(:output_example1) do
    '-   #1, state:   open, comments:   0, title: "This issue is test"'
  end

  let(:output_example2) do
    '-   #2, state: closed, comments:   4, title: "Closed Issue"'
  end

  let(:repos) do
    1.upto(3).map do |i|
      repo_name = "#{owner}/repository-#{i}"
      repo = double('repository')
      expect(repo).to receive(:full_name) { repo_name }
      expect_any_instance_of(Octokit::Client).to receive(:export_issues).with(repo_name)
      repo
    end
  end

  # describe '.export_issues', :vcr do
    # before do
      # expect_any_instance_of(Kernel).to receive(:puts).with(output_repo)
      # expect_any_instance_of(Kernel).to receive(:puts).with(output_example1)
      # expect_any_instance_of(Kernel).to receive(:puts).with(output_example2)
    # end

    # it 'calls puts, Dir.mkdir and File.open' do
      # expect(Octokit.export_issues repo).not_to be_nil
    # end

    # it 'requests HTTP' do
      # assert_requested :get, github_url("/repos/#{repo}")
      # assert_requested :get, github_url("/repos/#{repo}/issues?page=1&per_page=100&state=open")
      # assert_requested :get, github_url("/repos/#{repo}/issues?page=2&per_page=100&state=open")
      # assert_requested :get, github_url("/repos/#{repo}/issues?page=1&per_page=100&state=closed")
      # assert_requested :get, github_url("/repos/#{repo}/issues?page=2&per_page=100&state=closed")
      # assert_requested :get, github_url("/repos/#{repo}/issues/1/comments?page=1&per_page=100")
      # assert_requested :get, github_url("/repos/#{repo}/issues/2/comments?page=1&per_page=100")
      # assert_requested :get, github_url("/repos/#{repo}/issues/2/comments?page=2&per_page=100")
      # expect(Octokit.export_issues repo).not_to be_nil
    # end

    # it 'returns export finish time' do
      # expect(Octokit.export_issues repo).to be_kind_of Time
    # end
  # end

  describe '.export_user_issues' do
    before do
      expect_any_instance_of(Octokit::Client).to receive(:repos).
        with(owner) { repos }
    end

    it 'calls #repos and #export_issues' do
      expect(Octokit.export_user_issues owner).not_to be_nil
    end

    it 'returns time' do
      expect(Octokit.export_user_issues owner).to be_kind_of Time
    end
  end

  describe '.export_organization_issues' do
    before do
      expect_any_instance_of(Octokit::Client).to receive(:org_repos).
        with(organization) { repos }
    end

    it 'calls #repos and #export_issues' do
      expect(Octokit.export_organization_issues organization).not_to be_nil
    end

    it 'returns time' do
      expect(Octokit.export_organization_issues organization).to be_kind_of Time
    end
  end
end

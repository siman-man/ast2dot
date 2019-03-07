require 'ast2dot/version'
require 'ast2dot/node_label'
require 'erb'

class AST2Dot
  def self.render(code)
    new(code).render
  end

  attr_reader :ast, :graph_edges, :node_labels

  def initialize(code)
    @ast = RubyVM::AbstractSyntaxTree.parse(code)
    @template = File.read(File.expand_path('templates/default.dot.erb', __dir__))
  end

  def export
  end

  def render
    @graph_edges = []
    @node_labels = Hash.new

    node_labelling(ast)

    graph_data = ERB.new(@template, nil, '-').result(binding)
    graph_data.lines.map(&:rstrip).join("\n")
  end

  private

  def node_labelling(parent, index = 1)
    children_idx = parent.children.map do |child|
      next unless child.instance_of?(RubyVM::AbstractSyntaxTree::Node)

      index = node_labelling(child, index)
      index - 1
    end.compact

    children_idx.each do |idx|
      @graph_edges << { from: index, to: idx }
    end

    @node_labels[index] = parent.type

    index + 1
  end
end

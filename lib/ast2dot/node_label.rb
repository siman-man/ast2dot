class AST2Dot
  class NodeLabel
    def self.label(node)
      case node.type
      when :FCALL
        "%s\\nmethod_id: %p" % [node.type, node.children[0]]
      when :OPCALL
        "%s\\nmethod_id: %p" % [node.type, node.children[1]]
      when :LIT
        "%s\\nvalue: %p" % [node.type, node.children[0]]
      else
        node.type
      end
    end
  end
end

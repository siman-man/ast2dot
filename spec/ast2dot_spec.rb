RSpec.describe AST2Dot do
  describe '.render' do
    it 'test case 01' do
      code = <<~CODE
        puts 2 + 2
      CODE

      expect = <<~'EXP'.chomp
        digraph ast_graph {
          graph [ dpi = 200 ];

          1 [label="LIT"];
          2 [label="LIT"];
          3 [label="ARRAY"];
          4 [label="OPCALL"];
          5 [label="ARRAY"];
          6 [label="FCALL"];
          7 [label="SCOPE"];

          3 -> 2
          4 -> 1
          4 -> 3
          5 -> 4
          6 -> 5
          7 -> 6
        }
      EXP

      result = AST2Dot.render(code)
      expect(result).to eq(expect)
    end
  end
end

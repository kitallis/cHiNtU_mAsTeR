# Chintu's purpose in life is to remain single. Be small, stay compressed, as a working hack, although
# making sure that he is nicely expandable if needed for solving multiple problems later on. 
#
# He is usually a bit shy. He does get a little verbose when you annoy him too much. But that's okay.
# He's rumoured to have been heavily inspired by pie-man's values in life.
# This is a conversation recently heard between pie-man and Chintu :
#
#        <pie-man> : What's up, Chintu.
#  <chintu_master> : hey pie-man.
#  <chintu_master> : pie-man, nt yoozing auto-complete?
#        <pie-man> : No. I fear that I might auto-complete the wrong user-name and ping someone else for
#                    no reason.
#  <chintu_master> : ah, that iz gud thinking.
#  <chintu_master> : but nosrsly, i love ur values and ur perfection of living, i wish i wuz as awesome 
#                    as you.
#        <pie-man> : It's not about being awesome. It is about being perfect and not doing _anything_ 
#                    wrong.
#  <chintu_master> : i c what you mean.

TEMPLATE = <<EOS
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>A freshly generated Chintu Master -- <%= @version %> Website </title>
    <link rel="stylesheet" type="text/css" href="style.css" media="screen">
    <meta name="generator" content="ChintuMaster 1.0">
  </head>
  <body>
    <div id="main">
<%= yield %>
    <p><strong>This document was published on <%= @date %></strong></p>
    </div>
    <div id="sidebar">
      <h2>Documentation</h2>
      <ul>
        <li><a href="http://nanoc.stoneship.org/tutorial/">Tutorial</a></li>
        <li><a href="http://nanoc.stoneship.org/manual/">Manual</a></li>
        <li><a href="#{@permalink}">PermaLink</a></li>
      </ul>
      <h2>Community</h2>
      <ul>
        <li><a href="http://groups.google.com/group/nanoc/">Discussion Group</a></li>
        <li><a href="http://groups.google.com/group/nanoc-es/">Spanish Discussion Group</a></li>
        <li><a href="http://projects.stoneship.org/trHUMORac/nanoc/">Wiki</a></li>
      </ul>
    </div>
  </body>
</html>
EOS
DY = <<EOS
theme: default 
name: Shitallis
tagline: Lulfi
base_url: LOLGTFODUDE
EOS
DS = <<EOS
* {
  margin: 0;
  padding: 0;

  font-family: Georgia, Palatino, Times, 'Times New Roman', sans-serif;
}

body {
  background: #fff;
}

a {
  text-decoration: none;
}

a:link,
a:visited {
  color: #f30;
}

a:hover {
  color: #f90;
}

#main {
  position: absolute;

  top: 40px;
  left: 280px;

  width: 500px;
}

#main h1 {
  font-size: 40px;
  font-weight: normal;

  line-height: 40px;

  letter-spacing: -1px;
}

#main p {
  margin: 20px 0;
  
  font-size: 15px;
  
  line-height: 20px;
}

#main ul {
  margin: 20px;
}

#main li {
  list-style-type: square;

  font-size: 15px;
  
  line-height: 20px;
}

#sidebar {
  position: absolute;

  top: 40px;
  left: 20px;
  width: 200px;

  padding: 20px 20px 0 0;

  border-right: 1px solid #ccc;

  text-align: right;
}

#sidebar h2 {
  text-transform: uppercase;

  font-size: 13px;

  color: #333;

  letter-spacing: 1px;

  line-height: 20px;
}

#sidebar ul {
  list-style-type: none;

  margin: 20px 0;http://www.youtube.com/watch?v=v1s86vDhjx8
}

#sidebar li {
  font-size: 14px;

  line-height: 20px;
}
EOS
%w[rubygems rdiscount erb optparse yaml].map{|r|require r};
class Template;def initialize(hash) @version = "Version 1.0" 
hash.each_pair{|k, v| instance_variable_set('@' + k.to_s, v)} end 
def get_binding ;binding end end
module Setup A=proc{|x|Dir.chdir(x)};C=ARGV[0];B=proc{|f,w| File.open(f,'w'){|o| o.write w}}
def self.dirCreate;Dir.mkdir(C);A[C]
['themes','posts','out'].map{|a|puts"Creating /%s"%a;Dir.mkdir(a)}end
def self.fileCreate ;B['blog.yaml',DY];B['themes/style.css',DS]
B['themes/index.html',TEMPLATE.gsub(/^  /, '')]end 
def self.writeStatic ;Dir["themes/*css"].each{|file|B["#{Misc.slug(file,"themes/")}",File.read(file)]}
end end;class Metadata < Hash;protected;attr_accessor :DELIM;DELIM = /\A\s*\+-----\+(.+?)\+-----\+/m 
def self.parse(str) if str =~ DELIM;$1.strip.split("\n").inject(Metadata.new){
|meta, line|k,v = line.split(":", 2);meta[k.strip.to_sym] = v.strip;meta}
else Metadata.new end end end;class Post < Metadata;@@post = "";def self.parse(str) 
super @@post = str.gsub(DELIM,'');RDiscount.new(@@post).to_html end end
module Misc def self.check;if test ?e, 'blog.yaml';else puts "blog.yaml not found, exiting."
Process.exit end end;def self.slug(str,path) str.to_s.gsub(path,"out/") end end
module Spit;include Setup ;de = "";def self.main;Misc.check;Setup.writeStatic
files = Dir["posts/*.post"].each{|file| test(?f, file)};html = ERB.new(TEMPLATE)
files.each{|file| content = File.read(file);meta = Metadata.parse(content)
parse_meta = Template.new(meta);post = Post.parse(content);puts "Posting " + "#{file}" + "\n"
B["#{Misc.slug(file,"posts/")}.html",html.result(parse_meta.get_binding{post})]}end end
if __FILE__ == $0 ;if ARGV[0]=="--compile"then Spit.main else Setup.dirCreate;Setup.fileCreate end end

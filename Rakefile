DIST = "js"
SRC = "src"
CSS = "css"
STYLUS = "styl"
FONT_AWESOME = "misc/font-awesome-4.2.0"

task :default => [:build]

task :build => [:clean] do 
  sh "coffee -o #{DIST} -cb #{SRC}"
  sh "stylus -o #{CSS} #{STYLUS}"
  sh "cp -r #{FONT_AWESOME} css"
end

task :watch do
  sh "coffee -o #{DIST} -wb #{SRC}"
end

task :clean do
  sh "rm -rf #{DIST}/*"
end
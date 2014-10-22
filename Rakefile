SRC = "src"
COFFEE = "#{SRC}/coffee"
STYLUS = "#{SRC}/styl"

DIST = "dist"
CSS = "#{DIST}/css"
JS = "#{DIST}/js"
FONT_AWESOME = "misc/font-awesome-4.2.0"

task :default => [:build]

task :build => [:clean] do 
  sh "mkdir -p #{JS}"
  sh "mkdir -p #{CSS}"
  sh "coffee -o #{JS} -cb #{COFFEE}"
  sh "stylus -o #{CSS} #{STYLUS}"
  sh "cp -r #{FONT_AWESOME} #{CSS}"
end

task :watch do
  sh "coffee -o #{JS} -wb #{COFFEE}"
end

task :clean do
  sh "rm -rf #{DIST}"
end
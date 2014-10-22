DIST = "js"
SRC = "src"
CSS = "css"
STYLUS = "styl"

task :default => [:build]

task :build => [:clean] do 
  sh "coffee -o #{DIST} -cb #{SRC}"
  sh "stylus -o #{CSS} #{STYLUS}"
end

task :watch do
  sh "coffee -o #{DIST} -wb #{SRC}"
end

task :clean do
  sh "rm -rf #{DIST}/*"
end
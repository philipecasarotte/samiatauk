module ActionController
  module Caching

    class Sweeper

      PROTECTED_DIRECTORIES = ["images", "javascripts", "stylesheets", "system"]

      include ActionController::UrlWriter

      def sweep_directory(*dirs)
        dirs.each do |dir|
          next if PROTECTED_DIRECTORIES.include?(dir[/\w+/]) or !dir[/\w+/]
          cache_dir = RAILS_ROOT + "/public/#{dir[/\w+/]}"
          FileUtils.rm_r(Dir.glob(cache_dir+"/*")) rescue Errno::ENOENT
          RAILS_DEFAULT_LOGGER.info("Cache directory '#{cache_dir}' fully swept.")
        end
      end
    end
  end
end


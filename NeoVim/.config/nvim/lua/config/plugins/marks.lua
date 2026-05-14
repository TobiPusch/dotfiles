  -- Tastenkürzel für Marks (Standard):
  -- ---------------------------------
  -- ma-mz      : Mark setzen (lokal für diesen Buffer)
  -- mA-mZ      : Mark setzen (global/dateiubergreifend)
  -- `a         : Springe ZU Mark 'a' (exakte Position)
  -- 'a         : Springe zum Zeilenanfang von Mark 'a'
  --
  -- dm         : Mark in der aktuellen Zeile löschen (Fix: :MarksDeleteLine)
  -- dma        : Mark 'a' gezielt löschen
  -- dm-        : Alle Marks im aktuellen Buffer löschen
  -- dm<Space>  : Alle Bookmarks im aktuellen Buffer löschen
  --
  -- m] / m[    : Springe zum nächsten / vorherigen Mark
  -- m:         : Vorschau aller Marks (Preview)
  --
  -- Bookmarks (Feste Gruppen 0-9):
  -- ------------------------------
  -- m0-m9      : Bookmark der Gruppe X setzen/umschalten
  -- dm0-dm9    : Alle Bookmarks der Gruppe X löschen
  -- [' / ]'    : Springe zum nächsten / vorherigen Bookmark einer Gruppe

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {

    -- Standardeinstellungen laden.
    -- Setzt automatisch Icons an den linken Rand, wenn du 'm' drückst.
  default_mappings = true,
  },
}

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      divisi: {
        Row: {
          created_at: string | null
          id: number
          ketua_divisi_id: string | null
          nama_divisi: string
        }
        Insert: {
          created_at?: string | null
          id?: number
          ketua_divisi_id?: string | null
          nama_divisi: string
        }
        Update: {
          created_at?: string | null
          id?: number
          ketua_divisi_id?: string | null
          nama_divisi?: string
        }
        Relationships: [
          {
            foreignKeyName: "fk_ketua_divisi"
            columns: ["ketua_divisi_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      dokumentasi: {
        Row: {
          created_at: string | null
          event_id: number | null
          id: number
          uploader_id: string | null
          url_foto: string
        }
        Insert: {
          created_at?: string | null
          event_id?: number | null
          id?: number
          uploader_id?: string | null
          url_foto: string
        }
        Update: {
          created_at?: string | null
          event_id?: number | null
          id?: number
          uploader_id?: string | null
          url_foto?: string
        }
        Relationships: [
          {
            foreignKeyName: "dokumentasi_event_id_fkey"
            columns: ["event_id"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "dokumentasi_uploader_id_fkey"
            columns: ["uploader_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      event_kategori_mapping: {
        Row: {
          event_id: number
          id: number
          kategori_id: number
        }
        Insert: {
          event_id: number
          id?: number
          kategori_id: number
        }
        Update: {
          event_id?: number
          id?: number
          kategori_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "event_kategori_mapping_event_id_fkey"
            columns: ["event_id"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "event_kategori_mapping_kategori_id_fkey"
            columns: ["kategori_id"]
            isOneToOne: false
            referencedRelation: "kategori_event"
            referencedColumns: ["id"]
          },
        ]
      }
      event_links: {
        Row: {
          created_at: string | null
          event_id: number
          id: number
          nama_tautan: string
          url: string
        }
        Insert: {
          created_at?: string | null
          event_id: number
          id?: number
          nama_tautan: string
          url: string
        }
        Update: {
          created_at?: string | null
          event_id?: number
          id?: number
          nama_tautan?: string
          url?: string
        }
        Relationships: [
          {
            foreignKeyName: "event_links_event_id_fkey"
            columns: ["event_id"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id"]
          },
        ]
      }
      event_participants: {
        Row: {
          event_id: number
          id: string
          status: Database["public"]["Enums"]["participation_status"] | null
          user_id: string
          waktu_registrasi: string | null
        }
        Insert: {
          event_id: number
          id?: string
          status?: Database["public"]["Enums"]["participation_status"] | null
          user_id: string
          waktu_registrasi?: string | null
        }
        Update: {
          event_id?: number
          id?: string
          status?: Database["public"]["Enums"]["participation_status"] | null
          user_id?: string
          waktu_registrasi?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "event_participants_event_id_fkey"
            columns: ["event_id"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "event_participants_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      events: {
        Row: {
          created_at: string | null
          created_by: string | null
          deskripsi: string | null
          end_date: string | null
          id: number
          kuota: number | null
          lokasi_id: number | null
          nama_event: string
          start_date: string | null
          status: Database["public"]["Enums"]["event_status"] | null
        }
        Insert: {
          created_at?: string | null
          created_by?: string | null
          deskripsi?: string | null
          end_date?: string | null
          id?: number
          kuota?: number | null
          lokasi_id?: number | null
          nama_event: string
          start_date?: string | null
          status?: Database["public"]["Enums"]["event_status"] | null
        }
        Update: {
          created_at?: string | null
          created_by?: string | null
          deskripsi?: string | null
          end_date?: string | null
          id?: number
          kuota?: number | null
          lokasi_id?: number | null
          nama_event?: string
          start_date?: string | null
          status?: Database["public"]["Enums"]["event_status"] | null
        }
        Relationships: [
          {
            foreignKeyName: "events_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "events_lokasi_id_fkey"
            columns: ["lokasi_id"]
            isOneToOne: false
            referencedRelation: "lokasi"
            referencedColumns: ["id"]
          },
        ]
      }
      kategori_event: {
        Row: {
          created_at: string | null
          id: number
          nama_kategori: string
        }
        Insert: {
          created_at?: string | null
          id?: number
          nama_kategori: string
        }
        Update: {
          created_at?: string | null
          id?: number
          nama_kategori?: string
        }
        Relationships: []
      }
      lokasi: {
        Row: {
          created_at: string | null
          id: number
          kapasitas: number | null
          nama_ruangan: string
        }
        Insert: {
          created_at?: string | null
          id?: number
          kapasitas?: number | null
          nama_ruangan: string
        }
        Update: {
          created_at?: string | null
          id?: number
          kapasitas?: number | null
          nama_ruangan?: string
        }
        Relationships: []
      }
      news: {
        Row: {
          category: Database["public"]["Enums"]["news_category"] | null
          content: string | null
          created_at: string | null
          id: string
          image_url: string | null
          publisher_id: string | null
          title: string
        }
        Insert: {
          category?: Database["public"]["Enums"]["news_category"] | null
          content?: string | null
          created_at?: string | null
          id?: string
          image_url?: string | null
          publisher_id?: string | null
          title: string
        }
        Update: {
          category?: Database["public"]["Enums"]["news_category"] | null
          content?: string | null
          created_at?: string | null
          id?: string
          image_url?: string | null
          publisher_id?: string | null
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "news_publisher_id_fkey"
            columns: ["publisher_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      notifikasi: {
        Row: {
          created_at: string | null
          id: number
          judul: string
          pesan: string | null
          sender_id: string | null
          tipe: Database["public"]["Enums"]["notifikasi_tipe"] | null
        }
        Insert: {
          created_at?: string | null
          id?: number
          judul: string
          pesan?: string | null
          sender_id?: string | null
          tipe?: Database["public"]["Enums"]["notifikasi_tipe"] | null
        }
        Update: {
          created_at?: string | null
          id?: number
          judul?: string
          pesan?: string | null
          sender_id?: string | null
          tipe?: Database["public"]["Enums"]["notifikasi_tipe"] | null
        }
        Relationships: [
          {
            foreignKeyName: "notifikasi_sender_id_fkey"
            columns: ["sender_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      penerima_notifikasi: {
        Row: {
          created_at: string | null
          id: number
          is_read: boolean | null
          notif_id: number | null
          user_id: string | null
        }
        Insert: {
          created_at?: string | null
          id?: number
          is_read?: boolean | null
          notif_id?: number | null
          user_id?: string | null
        }
        Update: {
          created_at?: string | null
          id?: number
          is_read?: boolean | null
          notif_id?: number | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "penerima_notifikasi_notif_id_fkey"
            columns: ["notif_id"]
            isOneToOne: false
            referencedRelation: "notifikasi"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "penerima_notifikasi_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      tugas: {
        Row: {
          assign_type: string | null
          assigned_by_id: string | null
          created_at: string | null
          event_id: number | null
          id: number
          nama_tugas: string
        }
        Insert: {
          assign_type?: string | null
          assigned_by_id?: string | null
          created_at?: string | null
          event_id?: number | null
          id?: number
          nama_tugas: string
        }
        Update: {
          assign_type?: string | null
          assigned_by_id?: string | null
          created_at?: string | null
          event_id?: number | null
          id?: number
          nama_tugas?: string
        }
        Relationships: [
          {
            foreignKeyName: "tugas_assigned_by_id_fkey"
            columns: ["assigned_by_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tugas_event_id_fkey"
            columns: ["event_id"]
            isOneToOne: false
            referencedRelation: "events"
            referencedColumns: ["id"]
          },
        ]
      }
      tugas_assignments: {
        Row: {
          created_at: string | null
          id: number
          status_selesai: boolean | null
          tugas_id: number | null
          user_id: string | null
        }
        Insert: {
          created_at?: string | null
          id?: number
          status_selesai?: boolean | null
          tugas_id?: number | null
          user_id?: string | null
        }
        Update: {
          created_at?: string | null
          id?: number
          status_selesai?: boolean | null
          tugas_id?: number | null
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "tugas_assignments_tugas_id_fkey"
            columns: ["tugas_id"]
            isOneToOne: false
            referencedRelation: "tugas"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tugas_assignments_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      users: {
        Row: {
          avatar_url: string | null
          created_at: string | null
          divisi_id: number | null
          email: string
          id: string
          nama: string
          nim: string | null
          role: Database["public"]["Enums"]["user_role"] | null
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string | null
          divisi_id?: number | null
          email: string
          id: string
          nama: string
          nim?: string | null
          role?: Database["public"]["Enums"]["user_role"] | null
        }
        Update: {
          avatar_url?: string | null
          created_at?: string | null
          divisi_id?: number | null
          email?: string
          id?: string
          nama?: string
          nim?: string | null
          role?: Database["public"]["Enums"]["user_role"] | null
        }
        Relationships: [
          {
            foreignKeyName: "users_divisi_id_fkey"
            columns: ["divisi_id"]
            isOneToOne: false
            referencedRelation: "divisi"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      delete_my_account: { Args: never; Returns: undefined }
    }
    Enums: {
      event_category:
        | "Seminar"
        | "Certificate"
        | "Workshop"
        | "Industrial Visit"
        | "Course"
        | "Project"
        | "Celebration"
        | "Free"
        | "Paid"
        | "Limited"
        | "Meeting"
      event_status:
        | "AVAILABLE"
        | "UPCOMING"
        | "COMPLETED"
        | "DRAFT"
        | "PUBLISHED"
        | "CANCELLED"
        | "CLOSED"
      news_category: "ANNOUNCEMENT" | "ACHIEVEMENT" | "GENERAL"
      notifikasi_tipe: "GLOBAL" | "PERSONAL" | "GROUP"
      participation_status: "REGISTERED" | "ATTENDED" | "CANCELLED"
      user_role: "Anggota" | "Ketua Divisi" | "Ketua" | "Dosen" | "Wakil Ketua"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      event_category: [
        "Seminar",
        "Certificate",
        "Workshop",
        "Industrial Visit",
        "Course",
        "Project",
        "Celebration",
        "Free",
        "Paid",
        "Limited",
        "Meeting",
      ],
      event_status: [
        "AVAILABLE",
        "UPCOMING",
        "COMPLETED",
        "DRAFT",
        "PUBLISHED",
        "CANCELLED",
        "CLOSED",
      ],
      news_category: ["ANNOUNCEMENT", "ACHIEVEMENT", "GENERAL"],
      notifikasi_tipe: ["GLOBAL", "PERSONAL", "GROUP"],
      participation_status: ["REGISTERED", "ATTENDED", "CANCELLED"],
      user_role: ["Anggota", "Ketua Divisi", "Ketua", "Dosen", "Wakil Ketua"],
    },
  },
} as const

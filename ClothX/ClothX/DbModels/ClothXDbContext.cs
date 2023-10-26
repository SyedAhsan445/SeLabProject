using System;
using System.Collections.Generic;
using ClothX.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ClothX.DbModels
{
	public partial class ClothXDbContext : DbContext
	{
		public ClothXDbContext()
		{
		}

		public ClothXDbContext(DbContextOptions<ClothXDbContext> options)
			: base(options)
		{
		}

		public virtual DbSet<AspNetRole> AspNetRoles { get; set; } = null!;
		public virtual DbSet<AspNetRoleClaim> AspNetRoleClaims { get; set; } = null!;
		public virtual DbSet<AspNetUser> AspNetUsers { get; set; } = null!;
		public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; } = null!;
		public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; } = null!;
		public virtual DbSet<AspNetUserToken> AspNetUserTokens { get; set; } = null!;
		public virtual DbSet<ChatMessage> ChatMessages { get; set; } = null!;
		public virtual DbSet<ClientOrder> ClientOrders { get; set; } = null!;
		public virtual DbSet<ClientOrderIdeaImage> ClientOrderIdeaImages { get; set; } = null!;
		public virtual DbSet<Feature> Features { get; set; } = null!;
		public virtual DbSet<FeatureGroup> FeatureGroups { get; set; } = null!;
		public virtual DbSet<Log> Logs { get; set; } = null!;
		public virtual DbSet<Lookup> Lookups { get; set; } = null!;
		public virtual DbSet<OrderFeature> OrderFeatures { get; set; } = null!;
		public virtual DbSet<Prevelige> Preveliges { get; set; } = null!;
		public virtual DbSet<ProductCategory> ProductCategories { get; set; } = null!;
		public virtual DbSet<Review> Reviews { get; set; } = null!;
		public virtual DbSet<TailorProject> TailorProjects { get; set; } = null!;
		public virtual DbSet<TailorProjectImage> TailorProjectImages { get; set; } = null!;
		public virtual DbSet<UserProfile> UserProfiles { get; set; } = null!;

		protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
		{
			optionsBuilder.UseLazyLoadingProxies();
			optionsBuilder.UseSqlServer(DbSeeder.connectionString);
		}

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			modelBuilder.Entity<AspNetRole>(entity =>
			{
				entity.Property(e => e.Id)
					.HasMaxLength(128)
					.IsUnicode(false);

				entity.Property(e => e.Name).HasMaxLength(256);

				entity.Property(e => e.NormalizedName).HasMaxLength(256);

				entity.HasMany(d => d.Preveliges)
					.WithMany(p => p.Roles)
					.UsingEntity<Dictionary<string, object>>(
						"RolePrevelige",
						l => l.HasOne<Prevelige>().WithMany().HasForeignKey("PreveligeId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_RolePrevelige_Prevelige"),
						r => r.HasOne<AspNetRole>().WithMany().HasForeignKey("RoleId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_RolePrevelige_AspNetRoles"),
						j =>
						{
							j.HasKey("RoleId", "PreveligeId");

							j.ToTable("RolePrevelige");

							j.IndexerProperty<string>("RoleId").HasMaxLength(128).IsUnicode(false);
						});
			});

			modelBuilder.Entity<AspNetRoleClaim>(entity =>
			{
				entity.Property(e => e.RoleId)
					.HasMaxLength(128)
					.IsUnicode(false);

				entity.HasOne(d => d.Role)
					.WithMany(p => p.AspNetRoleClaims)
					.HasForeignKey(d => d.RoleId);
			});

			modelBuilder.Entity<AspNetUser>(entity =>
			{
				entity.Property(e => e.Id).HasMaxLength(128);

				entity.Property(e => e.Email).HasMaxLength(256);

				entity.Property(e => e.NormalizedEmail).HasMaxLength(256);

				entity.Property(e => e.NormalizedUserName).HasMaxLength(256);

				entity.Property(e => e.UserName).HasMaxLength(256);

				entity.HasMany(d => d.Roles)
					.WithMany(p => p.Users)
					.UsingEntity<Dictionary<string, object>>(
						"AspNetUserRole",
						l => l.HasOne<AspNetRole>().WithMany().HasForeignKey("RoleId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_AspNetUserRoles_AspNetRoles"),
						r => r.HasOne<AspNetUser>().WithMany().HasForeignKey("UserId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_AspNetUserRoles_AspNetUsers"),
						j =>
						{
							j.HasKey("UserId", "RoleId");

							j.ToTable("AspNetUserRoles");

							j.IndexerProperty<string>("UserId").HasMaxLength(128);

							j.IndexerProperty<string>("RoleId").HasMaxLength(128).IsUnicode(false);
						});
			});

			modelBuilder.Entity<AspNetUserClaim>(entity =>
			{
				entity.Property(e => e.UserId).HasMaxLength(128);

				entity.HasOne(d => d.User)
					.WithMany(p => p.AspNetUserClaims)
					.HasForeignKey(d => d.UserId);
			});

			modelBuilder.Entity<AspNetUserLogin>(entity =>
			{
				entity.HasKey(e => new { e.LoginProvider, e.ProviderKey });

				entity.Property(e => e.LoginProvider).HasMaxLength(128);

				entity.Property(e => e.ProviderKey).HasMaxLength(128);

				entity.Property(e => e.UserId).HasMaxLength(128);

				entity.HasOne(d => d.User)
					.WithMany(p => p.AspNetUserLogins)
					.HasForeignKey(d => d.UserId);
			});

			modelBuilder.Entity<AspNetUserToken>(entity =>
			{
				entity.HasKey(e => new { e.UserId, e.LoginProvider, e.Name });

				entity.Property(e => e.UserId).HasMaxLength(128);

				entity.Property(e => e.LoginProvider).HasMaxLength(128);

				entity.Property(e => e.Name).HasMaxLength(128);

				entity.HasOne(d => d.User)
					.WithMany(p => p.AspNetUserTokens)
					.HasForeignKey(d => d.UserId);
			});

			modelBuilder.Entity<ChatMessage>(entity =>
			{
				entity.ToTable("ChatMessage");

				entity.Property(e => e.AddedBy).HasMaxLength(100);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.IsActive)
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.Property(e => e.IsSeen)
					.HasColumnName("isSeen")
					.HasDefaultValueSql("((0))");

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

				entity.HasOne(d => d.SentByNavigation)
					.WithMany(p => p.ChatMessageSentByNavigations)
					.HasForeignKey(d => d.SentBy)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_ChatMessage_UserProfile");

				entity.HasOne(d => d.SentToNavigation)
					.WithMany(p => p.ChatMessageSentToNavigations)
					.HasForeignKey(d => d.SentTo)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_ChatMessage_UserProfile1");
			});

			modelBuilder.Entity<ClientOrder>(entity =>
			{
				entity.Property(e => e.AddedBy).HasMaxLength(50);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.Deadline).HasColumnType("datetime");

				entity.Property(e => e.IsActive)
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.Property(e => e.IsConfirmed).HasColumnName("isConfirmed");

				entity.Property(e => e.IsDelivered).HasColumnName("isDelivered");

				entity.Property(e => e.IsPaid).HasColumnName("isPaid");

				entity.Property(e => e.Measurements).HasMaxLength(200);

				entity.Property(e => e.Title).HasMaxLength(255);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

				entity.HasOne(d => d.Client)
					.WithMany(p => p.ClientOrders)
					.HasForeignKey(d => d.ClientId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_ClientOrders_UserProfile");

				entity.HasOne(d => d.OrderTypeNavigation)
					.WithMany(p => p.ClientOrders)
					.HasForeignKey(d => d.OrderType)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_ClientOrders_ProductCategory");
			});

			modelBuilder.Entity<ClientOrderIdeaImage>(entity =>
			{
				entity.HasOne(d => d.Order)
					.WithMany(p => p.ClientOrderIdeaImages)
					.HasForeignKey(d => d.OrderId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_ClientOrderIdeaImages_ClientOrders");
			});

			modelBuilder.Entity<Feature>(entity =>
			{
				entity.Property(e => e.AddedBy).HasMaxLength(100);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.IsActive)
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.Property(e => e.Name).HasMaxLength(100);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

				entity.HasOne(d => d.FeatureGroup)
					.WithMany(p => p.Features)
					.HasForeignKey(d => d.FeatureGroupId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_Features_FeatureGroups");
			});

			modelBuilder.Entity<FeatureGroup>(entity =>
			{
				entity.Property(e => e.AddedBy).HasMaxLength(100);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.IsActive).HasColumnName("isActive");

				entity.Property(e => e.Name).HasMaxLength(100);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
			});

			modelBuilder.Entity<Log>(entity =>
			{
				entity.Property(e => e.Date)
					.HasColumnType("datetime")
					.HasColumnName("date");

				entity.Property(e => e.Level)
					.HasMaxLength(100)
					.HasColumnName("level");

				entity.Property(e => e.Logger)
					.HasMaxLength(300)
					.HasColumnName("logger");

				entity.Property(e => e.Machinename)
					.HasMaxLength(300)
					.HasColumnName("machinename");

				entity.Property(e => e.Message).HasColumnName("message");
			});

			modelBuilder.Entity<Lookup>(entity =>
			{
				entity.ToTable("Lookup");

				entity.Property(e => e.Category).HasMaxLength(50);

				entity.Property(e => e.DisplayOrder).HasColumnName("displayOrder");

				entity.Property(e => e.Value).HasMaxLength(100);
			});

			modelBuilder.Entity<OrderFeature>(entity =>
			{
				entity.Property(e => e.IsActive)
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.HasOne(d => d.Feature)
					.WithMany(p => p.OrderFeatures)
					.HasForeignKey(d => d.FeatureId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_OrderFeatures_Features");

				entity.HasOne(d => d.Order)
					.WithMany(p => p.OrderFeatures)
					.HasForeignKey(d => d.OrderId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_OrderFeatures_ClientOrders");
			});

			modelBuilder.Entity<Prevelige>(entity =>
			{
				entity.ToTable("Prevelige");

				entity.Property(e => e.Name).HasMaxLength(50);
			});

			modelBuilder.Entity<ProductCategory>(entity =>
			{
				entity.ToTable("ProductCategory");

				entity.Property(e => e.AddedBy).HasMaxLength(100);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.IsActive).HasDefaultValueSql("((1))");

				entity.Property(e => e.Name).HasMaxLength(50);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");
			});

			modelBuilder.Entity<Review>(entity =>
			{
				entity.ToTable("Review");

				entity.Property(e => e.AddedBy).HasMaxLength(100);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.ResponseAddedOn).HasColumnType("datetime");

				entity.HasOne(d => d.User)
					.WithMany(p => p.Reviews)
					.HasForeignKey(d => d.UserId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_Review_UserProfile");
			});

			modelBuilder.Entity<TailorProject>(entity =>
			{
				entity.Property(e => e.AddedBy).HasMaxLength(50);

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.IsActive)
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.Property(e => e.Title).HasMaxLength(255);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

				entity.HasOne(d => d.ProductCategory)
					.WithMany(p => p.TailorProjects)
					.HasForeignKey(d => d.ProductCategoryId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_TailorProjects_ProductCategory");
			});

			modelBuilder.Entity<TailorProjectImage>(entity =>
			{
				entity.HasOne(d => d.Project)
					.WithMany(p => p.TailorProjectImages)
					.HasForeignKey(d => d.ProjectId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_TailorProjectImages_TailorProjects");
			});

			modelBuilder.Entity<UserProfile>(entity =>
			{
				entity.ToTable("UserProfile");

				entity.Property(e => e.AddedOn).HasColumnType("datetime");

				entity.Property(e => e.Address).HasMaxLength(255);

				entity.Property(e => e.FirstName).HasMaxLength(50);

				entity.Property(e => e.IsActive)
					.IsRequired()
					.HasColumnName("isActive")
					.HasDefaultValueSql("((1))");

				entity.Property(e => e.IsApproved).HasColumnName("isApproved");

				entity.Property(e => e.LastName).HasMaxLength(50);

				entity.Property(e => e.UpdatedOn).HasColumnType("datetime");

				entity.Property(e => e.UserId).HasMaxLength(128);

				entity.HasOne(d => d.GenderNavigation)
					.WithMany(p => p.UserProfiles)
					.HasForeignKey(d => d.Gender)
					.HasConstraintName("FK_UserProfile_Lookup");

				entity.HasOne(d => d.User)
					.WithMany(p => p.UserProfiles)
					.HasForeignKey(d => d.UserId)
					.OnDelete(DeleteBehavior.ClientSetNull)
					.HasConstraintName("FK_UserProfile_AspNetUsers");
			});

			OnModelCreatingPartial(modelBuilder);
		}

		partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
	}
}
